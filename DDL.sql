CREATE TABLE Member (
    member_id SERIAL PRIMARY KEY,
    username VARCHAR(255),
    height DECIMAL,
    weight DECIMAL
);

CREATE TABLE Trainer (
    trainer_id SERIAL PRIMARY KEY,
    member_id INTEGER REFERENCES Member(member_id)
);

CREATE TABLE Training_Session (
    trainer_id INTEGER REFERENCES Trainer(trainer_id),
    member_id INTEGER REFERENCES Member(member_id),
    start_date DATE,
    notes TEXT,
    duration DECIMAL,
    PRIMARY KEY (trainer_id, member_id, start_date)
);

CREATE TABLE Group_Event (
    group_event_id SERIAL PRIMARY KEY,
    name VARCHAR(255),
    description TEXT,
    event_type VARCHAR(100),
    start_date DATE,
    duration DECIMAL,
    cost DECIMAL
);

CREATE TABLE Manages_Event (
    trainer_id INTEGER REFERENCES Trainer(trainer_id),
    group_event_id INTEGER REFERENCES Group_Event(group_event_id),
    PRIMARY KEY (trainer_id, group_event_id)
);

CREATE TABLE Participant (
    member_id INTEGER REFERENCES Member(member_id),
    group_event_id INTEGER REFERENCES Group_Event(group_event_id),
    PRIMARY KEY (member_id, group_event_id)
);

CREATE TABLE Service (
    name VARCHAR(255) PRIMARY KEY,
    points INTEGER,
    base_cost DECIMAL
);

CREATE TABLE Transaction (
    member_id INTEGER REFERENCES Member(member_id),
    date DATE,
    service_type VARCHAR(255) REFERENCES Service(name),
    amount_paid DECIMAL,
    PRIMARY KEY (member_id, date, service_type)
);

CREATE TABLE Fitness_Goal (
    member_id INTEGER REFERENCES Member(member_id),
    name VARCHAR(255),
    description TEXT,
    complete BOOLEAN,
    PRIMARY KEY (member_id, name)
);

CREATE TABLE Achievement (
    achievement_id SERIAL PRIMARY KEY,
    description TEXT
);

CREATE TABLE Completed (
    member_id INTEGER REFERENCES Member(member_id),
    achievement_id INTEGER REFERENCES Achievement(achievement_id),
    PRIMARY KEY (member_id, achievement_id)
);
