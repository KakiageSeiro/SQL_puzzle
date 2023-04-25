\c hogedb

-- 米国政府の会計年度(10/1-9/30)のテーブル
-- 本ではテーブル名はキャメルケースだけど、このリポジトリではPostgreSQLを使ってるのでスネークケースにした。
CREATE TABLE hogeschema.fiscal_year_table1
(
    fiscal_year INT  NOT NULL PRIMARY KEY, -- 会計年度
    start_date  DATE NOT NULL,             -- 年度開始日。開始日は年次の1年前の10/1しか許可しない。
    CONSTRAINT valid_start_date CHECK (
            (EXTRACT(YEAR FROM start_date) = fiscal_year - 1) -- EXTRACT関数は第一引数で指定した数値を返す
            AND (EXTRACT(MONTH FROM start_date) = 10)
            AND (EXTRACT(DAY FROM start_date) = 01)
        ),
    end_date    DATE NOT NULL,             -- 年度終了日。終了日は年次と同年の9/30しか許可しない。
    CONSTRAINT valid_end_date CHECK (
            (EXTRACT(YEAR FROM end_date) = fiscal_year)
            AND (EXTRACT(MONTH FROM end_date) = 09)
            AND (EXTRACT(DAY FROM end_date) = 30)
        )
);

GRANT ALL PRIVILEGES ON hogeschema.fiscal_year_table1 TO hoge;

INSERT INTO hogeschema.fiscal_year_table1
VALUES (2001, '2000-10-01', '2001-09-30');
INSERT INTO hogeschema.fiscal_year_table1
VALUES (2002, '2001-10-01', '2002-09-30');
INSERT INTO hogeschema.fiscal_year_table1
VALUES (2003, '2002-10-01', '2003-09-30');
