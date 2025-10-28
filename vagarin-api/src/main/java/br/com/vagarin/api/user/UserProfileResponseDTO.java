package br.com.vagarin.api.user;

import java.time.LocalDate;
import java.util.UUID;

import org.locationtech.jts.geom.Point;

import lombok.Data;

@Data
public class UserProfileResponseDTO {

    private UUID id;
    private String firebaseUid;
    private String username;
    private String name;
    private LocalDate dateOfBirth;
    private String bio;
    private String profilePictureUrl;
    private String phoneNumber;

    private Double latitude;
    private Double longitude;

    // Configs
    private boolean configShowProximity;
    private boolean configIsPrivate;
    private boolean configNotifyReactions;
    private boolean configNotifyFriendPosts;
    private boolean configNotifyPostReminder;
    private boolean configNotifyNewFriendRequests;

    // Construtor para facilitar
    public UserProfileResponseDTO(User user) {
        this.id = user.getId();
        this.firebaseUid = user.getFirebaseUid();
        this.username = user.getUsername();
        this.name = user.getName();
        this.dateOfBirth = user.getDateOfBirth();
        this.bio = user.getBio();
        this.profilePictureUrl = user.getProfilePictureUrl();
        this.phoneNumber = user.getPhoneNumber();
        Point location = user.getLocation();
        if (location != null) {
            this.latitude = location.getY(); // Y é a Latitude
            this.longitude = location.getX(); // X é a Longitude
        }
        this.configShowProximity = user.isConfigShowProximity();
        this.configIsPrivate = user.isConfigIsPrivate();
        this.configNotifyReactions = user.isConfigNotifyReactions();
        this.configNotifyFriendPosts = user.isConfigNotifyFriendPosts();
        this.configNotifyPostReminder = user.isConfigNotifyPostReminder();
        this.configNotifyNewFriendRequests = user.isConfigNotifyNewFriendRequests();
    }
}