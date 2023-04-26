\c hogedb

-- テーブルとして作るけど、WITHとして作ったほうが良いかも
CREATE TABLE hogeschema.カレンダー
(
    日付 DATE,
    タイプ  VARCHAR(10) -- 休日 or 平日
);

GRANT ALL PRIVILEGES ON hogeschema.カレンダー TO hoge;

INSERT INTO hogeschema.カレンダー
    SELECT
        gen     AS 日付,
    CASE
        WHEN EXTRACT(DOW FROM gen) IN (0, 6) THEN '休日'
        ELSE '平日'
END AS タイプ
    FROM generate_series(
        CURRENT_DATE::date,
        (CURRENT_DATE + INTERVAL '1 YEAR')::date,
        '1 day'::interval
    ) AS gen
;


-- カレンダーをCURRENT_DATE起点で作るようにしたので、それに対応する欠勤データを作る。
-- 土日をまたいで2日休み
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-04-28', 'A', 1); -- 金曜日
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-04-29', 'A', 1); -- 土曜日
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-04-30', 'A', 1); -- 日曜日
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-05-01', 'A', 1); -- 月曜日
-- 単品の休み
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-05-03', 'A', 1); -- 水曜日
-- 金土で2日休み
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-05-05', 'A', 1); -- 金曜日
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-05-06', 'A', 1); -- 土曜日
-- 平日で2日休み
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-05-08', 'A', 1); -- 月曜日
INSERT INTO hogeschema.absenteeism VALUES (1, '2023-05-09', 'A', 1); -- 火曜日

-- 2日目以降の欠勤日を取得する(ルール2で点数が罰点がつかない欠勤日)
-- これをFROMのサブクエリにしてLEFT JOINして、caseでJOIN出来ている場合は0ポイントにすればよさそう
SELECT *
FROM hogeschema.absenteeism t1
JOIN hogeschema.カレンダー AS c
    ON  t1.absent_date = c.日付
    AND c.タイプ = '平日'
WHERE EXISTS (
    SELECT *
    FROM hogeschema.absenteeism t2
    WHERE t1.emp_id = t2.emp_id
    AND t1.absent_date = (t2.absent_date + INTERVAL '1 DAY')
)

