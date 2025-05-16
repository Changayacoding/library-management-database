-- Library Management System Database

-- Drop tables if they exist (to avoid errors on re-run)
DROP TABLE IF EXISTS BookAuthors;
DROP TABLE IF EXISTS Loans;
DROP TABLE IF EXISTS Books;
DROP TABLE IF EXISTS Authors;
DROP TABLE IF EXISTS Members;

-- Create Members table (Library users)
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    JoinDate DATE NOT NULL DEFAULT CURDATE()
);

-- Create Authors table
CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL
);

-- Create Books table
CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    ISBN VARCHAR(20) UNIQUE NOT NULL,
    PublishedYear YEAR,
    CopiesAvailable INT NOT NULL DEFAULT 1
);

-- Many-to-Many relationship table between Books and Authors
CREATE TABLE BookAuthors (
    BookID INT,
    AuthorID INT,
    PRIMARY KEY (BookID, AuthorID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON DELETE CASCADE,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) ON DELETE CASCADE
);

-- Create Loans table (tracks books borrowed by members)
CREATE TABLE Loans (
    LoanID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    LoanDate DATE NOT NULL DEFAULT CURDATE(),
    ReturnDate DATE,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Index for quick lookup of loans by member
CREATE INDEX idx_MemberLoans ON Loans(MemberID);

-- Index for quick lookup of loans by book
CREATE INDEX idx_BookLoans ON Loans(BookID);
