UPDATE Member SET weight = 78.5 WHERE member_id = 3;

UPDATE Training_Session
SET notes = 'Great session see you next week'
WHERE trainer_id = 1 AND member_id = 2;

UPDATE Fitness_Goal
SET complete = TRUE
WHERE member_id = 4 AND name = 'Flexibility';