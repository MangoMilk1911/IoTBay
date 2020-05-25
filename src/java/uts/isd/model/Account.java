package uts.isd.model;

import java.io.Serializable;
import java.sql.SQLException;

import uts.isd.model.dao.AccountDAO;


public abstract class Account implements Serializable {
    private String ID;
    private String firstName;
    private String lastName;
    private String email;
    private String password;

    Account(String ID, String firstName, String lastName, String email, String password) {
        this.ID = ID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
    }

    public static Character getAccountType(String email, String password) throws SQLException {
        return AccountDAO.getAccountType(email, password);
    }

    public char getAccountType() { return this.getClass().getSimpleName().charAt(0); }

    public String getID() { return ID; }
    public void setID(String ID) { this.ID = ID; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
