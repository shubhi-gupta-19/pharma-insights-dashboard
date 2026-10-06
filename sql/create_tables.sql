CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(50)
);

CREATE TABLE sales_reps (
    rep_id INT PRIMARY KEY,
    rep_name VARCHAR(50),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(50),
    specialty VARCHAR(50),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE medicines (
    medicine_id INT PRIMARY KEY,
    medicine_name VARCHAR(50),
    category VARCHAR(50),
    unit_price DECIMAL(10,2)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    rep_id INT,
    doctor_id INT,
    medicine_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (rep_id) REFERENCES sales_reps(rep_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id)
);