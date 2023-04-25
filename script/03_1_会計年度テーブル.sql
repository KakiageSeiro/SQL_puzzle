\c hogedb

-- 米国政府の会計年度(10/1-9/30)のテーブル
-- 本ではテーブル名はキャメルケースだけど、このリポジトリではPostgreSQLを使ってるのでスネークケースにした。
CREATE TABLE  hogeschema.fiscal_year_table1 (
  fiscal_year INT, -- 会計年度
  start_date DATE, -- 年度開始日
  end_date DATE    -- 年度終了日
);

GRANT ALL PRIVILEGES ON hogeschema.fiscal_year_table1 TO hoge;

INSERT INTO hogeschema.fiscal_year_table1 VALUES('1', '2000-10-01', '2001-09-30');
INSERT INTO hogeschema.fiscal_year_table1 VALUES('2', '2000-10-01', '2001-09-30');
INSERT INTO hogeschema.fiscal_year_table1 VALUES('3', '2000-10-01', '2001-09-30');
