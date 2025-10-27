package br.com.vagarin.api.user;

import lombok.Data;
import java.time.LocalDate;

@Data
public class UserUpdateRequestDTO {
    private String username;
    private String name;
    private LocalDate dateOfBirth;
    private String bio;
    private String profilePictureUrl;
    private String phoneNumber;

    private Double latitude;
    private Double longitude;

    private Boolean configShowProximity;
    private Boolean configIsPrivate;
    private Boolean configNotifyReactions;
    private Boolean configNotifyFriendPosts;
    private Boolean configNotifyPostReminder;
}