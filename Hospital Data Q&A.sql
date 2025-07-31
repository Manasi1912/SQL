DROP TABLE IF EXISTS Hospital_Data;
CREATE TABLE Hospital_Data(
	Hospital_Name VARCHAR(50),
	Location VARCHAR(50),
	Department VARCHAR(50),
	Doctors_Count INT,
	Patients_Count INT,
	Admission_Date DATE,
	Discharge_Date DATE,
	Medical_Expenses DECIMAL
);

SELECT * FROM Hospital_Data

-- i have imported csv file directly 


/* 1. Total Number of Patients 
o Write an SQL query to find the total number of patients across all hospitals. */
SELECT SUM(patients_count) AS total_patients
FROM Hospital_Data;


/* 2. Average Number of Doctors per Hospital 
o Retrieve the average count of doctors available in each hospital. */
SELECT hospital_name, AVG(doctors_count) AS doctors_available
FROM Hospital_Data
GROUP BY hospital_name;


/* 3. Top 3 Departments with the Highest Number of Patients 
o Find the top 3 hospital departments that have the highest number of patients. */
SELECT department, patients_count
FROM hospital_data
ORDER BY patients_count DESC 
LIMIT 3;


/* 4. Hospital with the Maximum Medical Expenses 
o Identify the hospital that recorded the highest medical expenses. */
SELECT hospital_name, medical_expenses
FROM hospital_data
ORDER BY medical_expenses DESC
LIMIT 1;


/* 5. Daily Average Medical Expenses 
o Calculate the average medical expenses per day for each hospital. */
SELECT hospital_name, admission_date, discharge_date, AVG(medical_expenses)
FROM hospital_data
GROUP BY hospital_name, admission_date, discharge_date;


/* 6. Longest Hospital Stay 
o Find the patient with the longest stay by calculating the difference between 
Discharge Date and Admission Date. */
SELECT (discharge_date - admission_date) AS stay
FROM hospital_data
ORDER BY stay DESC LIMIT 1;


/* 7. Total Patients Treated Per City 
o Count the total number of patients treated in each city. */
SELECT location, SUM(patients_count) AS patients_treated_per_city
FROM hospital_data
GROUP BY location;


/* 8. Average Length of Stay Per Department 
o Calculate the average number of days patients spend in each department. */
SELECT department, AVG(discharge_date - admission_date) AS avg_stay
FROM hospital_data
GROUP BY department;


/* 9. Identify the Department with the Lowest Number of Patients 
o Find the department with the least number of patients. */
SELECT department, patients_count
FROM hospital_data
ORDER BY patients_count 
LIMIT 1;


/*10. Monthly Medical Expenses Report 
• Group the data by month and calculate the total medical expenses for each month. */
SELECT DATE_TRUNC('month', admission_date) AS months, sum(medical_expenses) AS total_expenses
FROM hospital_data
GROUP BY months;