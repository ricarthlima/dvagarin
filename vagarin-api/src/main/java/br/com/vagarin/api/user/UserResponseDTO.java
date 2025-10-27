package br.com.vagarin.api.user;

import lombok.Data;
import org.locationtech.jts.geom.Point;

@Data
public class UserResponseDTO {
    private Long id;
    private String username;
    private String name;
    private String profilePictureUrl;
    private Double latitude;
    private Double longitude;

    // Construtor para facilitar a conversão
    public UserResponseDTO(User user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.name = user.getName();
        this.profilePictureUrl = user.getProfilePictureUrl();
        Point location = user.getLocation();
        if (location != null) {
            this.latitude = location.getY(); // Y é a Latitude
            this.longitude = location.getX(); // X é a Longitude
        }
    }
}