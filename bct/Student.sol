// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentDatabase {
    // Student struct to store data
    struct Student {
        uint256 id;
        string name;
        uint256 age;
        string course;
        uint256 enrollmentYear;
    }

    // Array to store all students
    Student[] private students;
    uint256 private nextId = 1; // Auto-increment ID

    // Event to log new students
    event StudentAdded(
        uint256 indexed id,
        string name,
        uint256 age,
        string course,
        uint256 enrollmentYear
    );

    // Add a new student
    function addStudent(
        string memory _name,
        uint256 _age,
        string memory _course,
        uint256 _enrollmentYear
    ) external {
        students.push(Student({
            id: nextId,
            name: _name,
            age: _age,
            course: _course,
            enrollmentYear: _enrollmentYear
        }));
        emit StudentAdded(nextId, _name, _age, _course, _enrollmentYear);
        nextId++;
    }

    // Get student by ID
    function getStudent(uint256 _id) external view returns (Student memory) {
        for (uint256 i = 0; i < students.length; i++) {
            if (students[i].id == _id) {
                return students[i];
            }
        }
        revert("Student not found");
    }

    // Get total students count
    function getTotalStudents() external view returns (uint256) {
        return students.length;
    }

    // Fallback function (optional: log unexpected ETH transfers)
    fallback() external payable {
        revert("This contract does not accept ETH. Use addStudent() instead.");
    }

    // Receive function (optional: same as fallback)
    receive() external payable {
        revert("ETH transfers not allowed");
    }
}