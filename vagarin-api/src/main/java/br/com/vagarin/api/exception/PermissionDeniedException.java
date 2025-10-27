package br.com.vagarin.api.exception;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

// Avisa ao Spring que esta exceção deve retornar 403
@ResponseStatus(HttpStatus.FORBIDDEN)
public class PermissionDeniedException extends RuntimeException {
    public PermissionDeniedException(String message) {
        super(message);
    }
}