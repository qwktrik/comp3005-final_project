SELECT * FROM Member;

SELECT m.username FROM Member m
LEFT JOIN Participant p ON m.member_id = p.member_id
WHERE p.member_id IS NULL;

SELECT * FROM Fitness_Goal
WHERE member_id = 1;

SELECT * FROM Transaction
WHERE member_id = 2
AND date > '2023-01-01'
ORDER BY date;

SELECT a.description AS achievement_description, m.username AS member_name
FROM Achievement a
JOIN Completed c ON a.achievement_id = c.achievement_id
JOIN Member m ON c.member_id = m.member_id;

SELECT * FROM Training_Session WHERE member_id = 3;

SELECT * FROM Group_Event
WHERE group_event_id IN (
	SELECT group_event_id FROM Participant WHERE member_id = 2
);