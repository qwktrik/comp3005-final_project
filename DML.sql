INSERT INTO Member (username, height, weight) VALUES
    ('Quote', 180, 75),
    ('CurlyBrace', 165, 60),
    ('King', 175, 80),
    ('Sue', 160, 55),
    ('Balrog', 100, 200);

INSERT INTO Trainer (member_id) VALUES
    (1),
    (3);

INSERT INTO Training_Session (trainer_id, member_id, start_date, notes, duration) VALUES
    (1, 2, '2023-01-15', 'Targets 50m + 10km Run', 120),
    (2, 5, '2023-02-20', 'Spar', 45);

INSERT INTO Group_Event (name, description, event_type, start_date, duration, cost) VALUES
    ('Yoga Class', 'Calm down with some good tunes and good vibes', 'Yoga', '2023-03-10', 60, 15.99),
    ('Outer Wall Climb', 'Level 5 Climb (Bring a Harness!!)', 'Fitness', '2023-04-05', 45, 20.50);

INSERT INTO Manages_Event (trainer_id, group_event_id) VALUES
    (2, 1),
    (1, 2);

INSERT INTO Participant (member_id, group_event_id) VALUES
    (2, 1),
    (4, 2),
    (5, 1);

INSERT INTO Service (name, points, base_cost) VALUES
    ('Yoga Class', 10, 15.99),
    ('Fitness Climb', 15, 20.50),
    ('Membership', 0, 50);

INSERT INTO Transaction (member_id, date, service_type, amount_paid) VALUES
    (1, '2023-01-20', 'Membership', 50.00),
    (2, '2023-02-25', 'Yoga Class', 15.99),
    (4, '2023-03-12', 'Fitness Climb', 20.50);

INSERT INTO Fitness_Goal (member_id, name, description, complete) VALUES
    (1, 'Jetpack', 'Climb the Outerwall in less than a minute', FALSE),
    (2, 'Flexibility', 'Improve flexibility through yoga', TRUE),
    (5, 'Beat King in Spar', 'Kick his ass yooooo', FALSE);

INSERT INTO Achievement (description) VALUES
    ('Complete Sand Zone trail'),
    ('Win a Spar using the Nemesis'),
    ('All zones marathon in under 1 hour');

INSERT INTO Completed (member_id, achievement_id) VALUES
    (1, 2),
    (4, 1),
    (5, 3);