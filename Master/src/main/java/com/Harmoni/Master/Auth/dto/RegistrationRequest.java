package com.Harmoni.Master.Auth.dto;

import java.util.List;

// This DTO mirrors the UserRegisterDto in the Auth service
public class RegistrationRequest {
    private Integer roleId;
    private String username;
    private String firstName;
    private String lastName;
    private String email;
    private String contactNumber;
    private String streetAddress;
    private Integer stateId;
    private Integer cityId;
    private String specialCategory;
    private List<Integer> workhnadCategoryIds;

    // Getters and Setters
    public Integer getRoleId() { return roleId; }
    public void setRoleId(Integer roleId) { this.roleId = roleId; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getContactNumber() { return contactNumber; }
    public void setContactNumber(String contactNumber) { this.contactNumber = contactNumber; }
    public String getStreetAddress() { return streetAddress; }
    public void setStreetAddress(String streetAddress) { this.streetAddress = streetAddress; }
    public Integer getStateId() { return stateId; }
    public void setStateId(Integer stateId) { this.stateId = stateId; }
    public Integer getCityId() { return cityId; }
    public void setCityId(Integer cityId) { this.cityId = cityId; }
    public String getSpecialCategory() { return specialCategory; }
    public void setSpecialCategory(String specialCategory) { this.specialCategory = specialCategory; }
    public List<Integer> getWorkhnadCategoryIds() { return workhnadCategoryIds; }
    public void setWorkhnadCategoryIds(List<Integer> workhnadCategoryIds) { this.workhnadCategoryIds = workhnadCategoryIds; }
}
