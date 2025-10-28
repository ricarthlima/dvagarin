package br.com.vagarin.api.device;

import lombok.Data;

@Data
public class DeviceRegistrationRequestDTO {
    private String fcmToken;
}