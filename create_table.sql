-- 创建 conference_users 表
CREATE TABLE conference_users (
  id bigint primary key generated always as identity,
  name text not null,
  phone text not null,
  hotel text default '',
  seat_number text default '',
  meal_number text default '',
  created_at timestamp with time zone default now(),
  updated_at timestamp with time zone default now()
);

-- 开启行级安全
ALTER TABLE conference_users ENABLE ROW LEVEL SECURITY;

-- 添加安全策略（允许公开读取和写入）
CREATE POLICY "Allow public read access" ON conference_users
  FOR SELECT USING (true);

CREATE POLICY "Allow public write access" ON conference_users
  FOR ALL USING (true);

-- 插入测试数据
INSERT INTO conference_users (name, phone, hotel, seat_number, meal_number)
VALUES
  ('测试', '13800138000', '酒店A', 'A区 01', '第 1 桌'),
  ('张三', '13900139000', '酒店B', 'B区 02', '第 2 桌'),
  ('李四', '13700137000', '酒店A', 'C区 03', '第 3 桌');
