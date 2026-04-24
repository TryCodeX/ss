-- 为 conference_users 表添加 id 列作为主键
ALTER TABLE conference_users
ADD COLUMN id bigint primary key generated always as identity;

-- 验证表结构
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'conference_users';