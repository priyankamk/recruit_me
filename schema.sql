CREATE DATABASE recruitme;

CREATE TABLE jobs
(
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(200),
    job_title VARCHAR(200),
    about_company VARCHAR(600),
    about_job VARCHAR(600),
    location VARCHAR(100)
);

ALTER TABLE jobs ADD COLUMN employer_id INTEGER;

CREATE TABLE employers
(
    id SERIAL PRIMARY KEY,
    email VARCHAR(600),
    password_digest VARCHAR(600)
);

CREATE TABLE candidates
(
    id SERIAL PRIMARY KEY,
    name VARCHAR(200),
    summary TEXT,
    career_history TEXT,
    education VARCHAR(600),
    skills VARCHAR(600),
    email VARCHAR(600),
    password_digest VARCHAR(600)
);

CREATE TABLE applications
(
    id SERIAL PRIMARY KEY,
    employer_id INTEGER,
    candidate_id INTEGER
);


INSERT INTO jobs
    (company_name, job_title, about_company, about_job, location)
VALUES
    ('infosys', 'full stack developer', 'Infosys is a global leader in next generation digital services and consulting. We enable clients in 45 countries to navigate their digital transformation.', 'Web development fundamentals in HTML, CSS, Javascript and JQuery', 'melbourne');

INSERT INTO candidates
    (name, summary, career_history, education, skills)
VALUES
    ('Sabrina', 'I am a web developer and recent graduate of the Web Development Immersive Course at General Assembly. I enjoy working with numbers and I am passionate about understanding how things work and applying logic to solve problems.', 'Web developher at envato', 'General Assembly', 'Html,Javascript,Css,Ruby');