# 会务系统（Supabase 版）

本目录包含两个页面：

- `index.html`: 前台用户查询/登录（样式保持原版，主要用于微信 H5）
- `admin.html`: 管理后台（需要管理员登录后才能访问数据管理功能）

## Supabase 配置

当前页面内置的 Supabase 连接信息：

- URL: `https://kanqjlqncwpxdidsltzq.supabase.co`
- Key: `sb_publishable_tGPNdD0vZkqofDpUMcgmOQ_4a_VtdsO`

说明：

- `index.html` 使用匿名 key 进行只读查询（RLS 需要允许 `anon` SELECT）。
- `admin.html` 使用 Supabase Auth 登录获取 `authenticated` 会话，再通过 RLS 控制写入权限。

## 管理员登录

管理员账号和密码见 `admin_credentials.md`。

管理员登录策略：

- `admin.html` 需要先登录，才会显示后台页面和执行任何查询/写入。
- 额外增加了邮箱白名单（allowlist），需要在 `admin.html` 里将 `ADMIN_EMAIL_ALLOWLIST` 设置成你的管理员邮箱列表。

## 必做：开启 RLS 策略

请在 Supabase SQL Editor 中执行 `admin_rls.sql`。

这会实现：

- `anon` 仅允许 `conference_users` 读取
- 仅允许白名单管理员邮箱对 `conference_users` 写入（增删改）

## 表结构建议

推荐使用 snake_case 列名（与 SQL 脚本一致）：

- `seat_number`
- `meal_number`
- `created_at`
- `updated_at`

如果你之前的表用了 `seatNumber/createdAt` 这类 camelCase，`admin.html`/`index.html` 已做兼容映射，但长期建议统一成 snake_case。

## 微信 JSSDK（导航）接入

前端已改为通过签名接口动态获取 `wx.config` 参数，默认接口地址：

- `GET /api/wechat/jssdk-sign?url=<当前页面完整URL(不带#)>`

接口返回 JSON 必须包含：

```json
{
  "appId": "wx_xxx",
  "timestamp": 1710000000,
  "nonceStr": "random_string",
  "signature": "sha1_signature"
}
```

如果你的后端地址不同，可在页面提前设置：

```html
<script>
  window.WECHAT_SIGN_ENDPOINT = "https://your-domain.com/api/wechat/jssdk-sign";
</script>
```

上线前确认：

- 微信公众平台已配置 `JS接口安全域名`
- H5 页面使用 `https`
