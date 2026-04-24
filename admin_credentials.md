# 管理后台账号（请妥善保管）

建议使用 Supabase Auth 的 Email/Password 登录方式。你可以在 Supabase 控制台创建一个管理员账号（Email/Password），并在 `ss/admin.html` 的 `ADMIN_EMAIL_ALLOWLIST` 中保持一致。

默认管理员账号（建议创建）：

- 邮箱：`admin@ss.local`
- 密码：`SsAdmin@2026!`

说明：

- 这是我为你生成的一组管理员账号密码（便于部署/交付），但我无法直接替你在 Supabase 后台创建该用户；需要你在 Supabase Dashboard 的 Auth 里创建。
- 创建完成后，用这个账号登录 `admin.html` 才能进入后台数据页面。
- 强烈建议在生产环境中修改密码，并只在 HTTPS 域名下使用。

