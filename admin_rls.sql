-- Admin RLS policies for conference_users
-- Apply in Supabase SQL Editor.
--
-- Notes:
-- 1) This assumes the table has RLS enabled.
-- 2) Public (anon) should only have SELECT (for index.html name-based lookup).
-- 3) Admin (authenticated with allowed email) can INSERT/UPDATE/DELETE.
--
-- Customize admin email(s) in the allowlist below to match `ss/admin.html`.

-- Ensure RLS is enabled
ALTER TABLE public.conference_users ENABLE ROW LEVEL SECURITY;

-- Remove overly-permissive policies if they exist
DROP POLICY IF EXISTS "Allow public write access" ON public.conference_users;
DROP POLICY IF EXISTS "Allow public read access" ON public.conference_users;
DROP POLICY IF EXISTS "Public read" ON public.conference_users;
DROP POLICY IF EXISTS "Admin write" ON public.conference_users;

-- Public read-only access (for index.html)
CREATE POLICY "Public read"
ON public.conference_users
FOR SELECT
TO anon
USING (true);

-- Admin full write access
-- Replace the email list with your real admin emails.
CREATE POLICY "Admin write"
ON public.conference_users
FOR ALL
TO authenticated
USING (
  auth.jwt() ->> 'email' IN ('admin@ss.local')
)
WITH CHECK (
  auth.jwt() ->> 'email' IN ('admin@ss.local')
);

