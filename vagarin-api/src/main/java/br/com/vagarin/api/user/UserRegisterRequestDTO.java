package br.com.vagarin.api.user;

import java.time.LocalDate;

import lombok.Data;

@Data
public class UserRegisterRequestDTO {

    private String firebaseUid;

    private String username;
    private String name;
    private LocalDate dateOfBirth;
    private String bio;
    private String profilePictureUrl;
    private String phoneNumber;
}