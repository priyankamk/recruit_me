CREATE DATABASE recruitme;

CREATE TABLE jobs(
    id SERIAL PRIMARY KEY,
    company_name VARCHAR(200),
    job_title VARCHAR(200),
    about_company VARCHAR(600),
    about_job VARCHAR(600),
    location VARCHAR(100)
);

INSERT INTO jobs(company_name, job_title, about_company, about_job, location) VALUES ('infosys','full stack developer','Infosys is a global leader in next generation digital services and consulting. We enable clients in 45 countries to navigate their digital transformation.','Web development fundamentals in HTML, CSS, Javascript and JQuery','melbourne');