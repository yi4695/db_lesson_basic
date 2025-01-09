Q1 新たに部署のテーブルを追加

CREATE TABLE departments (
  department_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(20) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
  );


Q2 peopleテーブルに新しいカラムを追加

ALTER TABLE people ADD COLUMN department_id INT UNSIGNED AFTER email;


Q3 レコードを作成

追加する部署一覧

INSERT INTO departments (name)
  VALUES
  ('営業'), ('開発'), ('経理'), ('人事'), ('情報システム');


追加する人の条件

INSERT INTO people (name, email, department_id, age, gender)
  VALUES
  ('河野美紀', 'kouno@gizumo.jp', 3, 43, 2),
  ('中尾昇', 'nakao@gizumo.jp', 1, 35, 1),
  ('吉岡葵', 'yoshioka@gizumo.jp', 5, 64, 2),
  ('西川直美', 'nishikawa@gizumo.jp', 1, 34, 2),
  ('中村綾乃', 'nakamura@gizumo.jp', 2, 31, 2),
  ('池田次郎', 'ikeda@gizumo.jp', 2, 58, 1),
  ('前田直人', 'maeda@gizumo.jp', 4, 65, 1),
  ('根本知子', 'nemoto@gizumo.jp', 2, 23, 2),
  ('宮田武夫', 'miyata@gizumo.jp', 2, 38, 1),
  ('小西勇', 'konishi@gizumo.jp', 1, 21, 1);


追加する日報の条件

INSERT INTO reports (person_id, content)
  VALUES
  (7, '備品の在庫管理リストの更新'),
  (8, '新規顧客2件のアポイント取得'),
  (9, '月次報告資料のデータ集計'),
  (10, '既存顧客フォローアップ3件'),
  (11, '〇〇機能の実装が100％完了'),
  (12, 'バグの修正が80％完了'),
  (13, '月次報告書の最終チェック'),
  (14, '〇〇ツールの勉強会に参加'),
  (15, 'チームミーティングの議題整理'),
  (16, '提案資料作成の補助業務');


Q4 不完全なデータを条件に当てはまる値で埋める

UPDATE people SET department_id = 1 WHERE person_id < 3;

UPDATE people SET department_id = 5 WHERE person_id IN (3, 4);

UPDATE people SET department_id = 4 WHERE person_id = 6;


Q5 年齢の降順で男性の名前と年齢を取得

SELECT name, age FROM people WHERE gender = 1 ORDER BY age DESC;


Q6

people テーブルの name, email, age カラムの department_id が 1 のレコードを
created_at の昇順で表示する


Q7 20代の女性と40代の男性の名前一覧を取得

SELECT name FROM people WHERE age BETWEEN 20 AND 29 AND gender =2
  OR age BETWEEN 40 AND 49 AND gender = 1;


Q8 営業部に所属する人だけを年齢の昇順で取得

SELECT * FROM people WHERE department_id = 1 ORDER BY age;


Q9 開発部に所属している女性の平均年齢を取得

SELECT AVG(age) AS average_age FROM people
  WHERE department_id = 2 AND gender = 2;


Q10 名前と部署名とその人が提出した日報の内容を同時に取得（日報を提出していない人は含めない）

SELECT people.name, departments.name, reports.content
  FROM reports
    LEFT OUTER JOIN people
    USING (person_id)
      RIGHT OUTER JOIN departments
      USING (department_id);


Q11 日報を一つも提出していない人の名前一覧を取得

SELECT people.name FROM people
  LEFT OUTER JOIN reports
  USING (person_id)
    WHERE content IS NULL;
