CREATE DATABASE dental_tech;
USE Dental_Tech;

-- Tabla users
CREATE TABLE users (
    iduser INT auto_increment primary Key,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    email VARCHAR(100),
    user_password VARCHAR (45)
);

INSERT INTO users (iduser, first_name, last_name, email, user_password) VALUES -- se ingresan usuarios
(1, 'Carlos', 'Madero Gutierrez', 'cmaderog@gmail.com', 'Carlosdental1'),
(2, 'Andrea', 'Gomez Ramirez', 'andigo@gmail.com', 'Andidental2'),
(3, 'Erika', 'Durante Osorio', 'erios@gmail.com', 'Erika123'),
(4, 'Monica', 'Vera Roa', 'moniRo@gmail.com', 'Monica1234'),
(5, 'Diego Elias', 'Garcia Garcia', 'diegoE-g@gmail.com', 'Diego12345');

SELECT * FROM users;

-- Tabla patients 
CREATE TABLE patients (
    idpatient INT auto_increment primary Key,
    address VARCHAR(45),
    phone VARCHAR(45),
    iduser INT UNIQUE,
    FOREIGN KEY (iduser) REFERENCES users(iduser)
);

INSERT INTO patients (address, phone, iduser) VALUES -- se ingresan usuarios
('Calle Londres 106, Cuauhtémoc', ' 55 1234 5678', 1),
('Calle de Bolívar 28, Cuauhtémoc', '55 9876 5432', 2),
('Calle de Orizaba 131, Cuauhtémoc', '55 2345 6789', 3),
('Calle de la Amargura 15, Álvaro Obregón', '55 8765 4321', 4),
('Avenida Insurgentes Sur 1571, Benito Juárez', '55 3456 7890', 5);

SELECT * FROM patients;

-- Tabla products
CREATE TABLE products (
    idproduct INT auto_increment primary Key,
    product_name VARCHAR(45),
    stock INT,
    price DECIMAL(10,2),
    category VARCHAR(45),
    iduser INT,
    idpatient INT,
    FOREIGN KEY (iduser) REFERENCES users(iduser),
    FOREIGN KEY (idpatient) REFERENCES patients(idpatient)
);

INSERT INTO products (product_name, stock, price, category, iduser, idpatient) VALUES
('Pasta Dental Sensodyne 113ml', 120, 11.17, 'Pastas', 1, 1),
('Cepillo Dental Disney', 80, 65.00, 'Infantil', 2, 2),
('Enjuague Bucal Listerine 500ml', 60, 90.00, 'Enjuagues', 3, 3),
('Hilo Dental Oral-B 50m 2pack', 150, 96.00, 'Hilo Dental', 4, 4),
('Cepillo Dental Colgate Electrico', 20, 539.00, 'Cepillos', 5, 5);

SELECT * FROM products; 

-- Tabla orders 
CREATE TABLE orders (
    idorder INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    total DECIMAL(10,2),
    order_status VARCHAR(45),
    quantity INT,
    unit_price DECIMAL(10,2)
);

INSERT INTO orders (order_date, total, order_status, quantity, unit_price)
VALUES
('2024-09-01', 222.34, 'Procesado', 2, 111.17),     -- Pasta Dental Sensodyne
('2024-08-28', 195.00, 'Enviado', 3, 65.00),        -- Cepillo Dental Disney
('2024-09-05', 90.00, 'Entregado', 1, 90.00),      -- Enjuague Bucal Listerine
('2024-09-02', 288.00, 'Cancelado', 3, 96.00),     -- Hilo Dental Oral-B
('2024-09-03', 539.00, 'Pendiente', 1, 539.00);     -- Cepillo Dental Colgate Electrico

SELECT * FROM orders; 

-- Tabla product_has_order (tabla pivote)
CREATE TABLE product_has_order (
    idproduct INT,
    idorder INT,
    PRIMARY KEY (idproduct, idorder),
	FOREIGN KEY (idproduct) REFERENCES products(idproduct),
	FOREIGN KEY (idorder) REFERENCES orders(idorder)
);
-- Tabla doctors
CREATE TABLE doctors (
    iddoctor INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    speciality VARCHAR(45)
);

INSERT INTO doctors (first_name, last_name, speciality) VALUES
('Ana', 'Martínez', 'Ortodoncia'),
('Carlos', 'Gómez', 'Endodoncia'),
('María', 'Pérez', 'Peridoncia'),
('Luis', 'Rodríguez', 'Prostodoncia'),
('Elena', 'Sánchez', 'Pedodoncia');

SELECT * FROM doctors; 


-- Tabla treatments
CREATE TABLE treatments (
    idtreatment INT AUTO_INCREMENT PRIMARY KEY,
    treatment_name VARCHAR(45),
    price DECIMAL(10,2),
    iddoctor INT UNIQUE,
    FOREIGN KEY (iddoctor) REFERENCES doctors(iddoctor)
);

INSERT INTO treatments (treatment_name, price, iddoctor) VALUES 
('Implante dental', 17000.00, 1),         
('Limpieza profunda', 7000.00, 2), 
('Tratamiento de conducto', 4000.00, 3),
('Extracción de muela del juicio', 4000.00, 4),
('Ortodoncia', 25000.00, 5);

SELECT * FROM treatments;

-- Tabla appointments
CREATE TABLE appointments (
    idappointment INT AUTO_INCREMENT PRIMARY KEY,
    date_time DATETIME,
    reason VARCHAR(45),
    idpatient INT,
    idtreatment INT,
    FOREIGN KEY (idpatient) REFERENCES patients(idpatient),
    FOREIGN KEY (idtreatment) REFERENCES treatments(idtreatment)
);

INSERT INTO appointments (date_time, reason, idpatient, idtreatment) VALUES
('2024-09-12 10:30:00', 'Limpieza', 1, 2),
('2024-09-25 11:30:00', 'Valoración', 2, 4),
('2024-10-01 13:00:00', 'Seguimiento de tratamiento', 3, 1),
('2024-10-10 14:45:00', 'Inicio de tratamiento', 4,3),
('2024-11-15 17:00:00', 'Valoración para inicio de tratamiento', 5,5);

SELECT * FROM appointments;

