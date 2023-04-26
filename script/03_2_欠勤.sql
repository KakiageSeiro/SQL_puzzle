\c hogedb

-- それっぽい前提テーブル
CREATE TABLE hogeschema.personnel -- 社員テーブル
(
    emp_id INTEGER NOT NULL, -- 社員ID
    PRIMARY KEY (emp_id)
);

GRANT ALL PRIVILEGES ON hogeschema.personnel TO hoge;

INSERT INTO hogeschema.personnel VALUES (1);
INSERT INTO hogeschema.personnel VALUES (2);
INSERT INTO hogeschema.personnel VALUES (3);

-- 言い訳テーブル
CREATE TABLE hogeschema.excuse_list
(
    reason_code CHAR(40) NOT NULL, -- 理由コード
    reason_description CHAR(40) NOT NULL, -- 理由説明
    PRIMARY KEY (reason_code)
);

GRANT ALL PRIVILEGES ON hogeschema.excuse_list TO hoge;

INSERT INTO hogeschema.excuse_list VALUES ('A', '寝坊');
INSERT INTO hogeschema.excuse_list VALUES ('B', 'おばあさんに道案内');
INSERT INTO hogeschema.excuse_list VALUES ('C', 'ストライキ');

-- 欠勤テーブル
CREATE TABLE hogeschema.absenteeism
(
    emp_id INTEGER NOT NULL REFERENCES hogeschema.personnel(emp_id), -- 社員ID
    absent_date DATE NOT NULL, -- 欠勤日
    reason_code CHAR(40) NOT NULL REFERENCES hogeschema.excuse_list(reason_code), -- 理由コード
    severity_points INTEGER NOT NULL CHECK(severity_points BETWEEN 1 AND 4), -- 罰点
    PRIMARY KEY (emp_id, absent_date)
);

GRANT ALL PRIVILEGES ON hogeschema.absenteeism TO hoge;

INSERT INTO hogeschema.absenteeism VALUES (1, '2019-01-01', 'A', 1);
INSERT INTO hogeschema.absenteeism VALUES (1, '2019-01-02', 'B', 2);
INSERT INTO hogeschema.absenteeism VALUES (1, '2019-01-03', 'C', 3);

-- ルール1 罰点が年間40ポイントためるともれなくクビ
-- ルール2 2日以上連続して休んだ場合は「長期病欠」扱いとなり、2日目以降は罰点がつかないし、欠勤の総日数にカウントされない




