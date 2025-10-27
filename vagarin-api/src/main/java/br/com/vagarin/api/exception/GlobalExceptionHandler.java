package br.com.vagarin.api.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.context.request.WebRequest;

// 1. Avisa ao Spring que esta classe vai "aconselhar" os controllers
@ControllerAdvice
public class GlobalExceptionHandler {

    // 2. Handler para "Não Encontrado" (404)
    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponseDTO> handleResourceNotFoundException(
            ResourceNotFoundException ex, WebRequest request) {

        ErrorResponseDTO errorResponse = new ErrorResponseDTO(
                HttpStatus.NOT_FOUND.value(), // 404
                "Not Found",
                ex.getMessage(),
                request.getDescription(false).replace("uri=", ""));
        return new ResponseEntity<>(errorResponse, HttpStatus.NOT_FOUND);
    }

    // 3. Handler para "Sem Permissão" (403)
    @ExceptionHandler(PermissionDeniedException.class)
    public ResponseEntity<ErrorResponseDTO> handlePermissionDeniedException(
            PermissionDeniedException ex, WebRequest request) {

        ErrorResponseDTO errorResponse = new ErrorResponseDTO(
                HttpStatus.FORBIDDEN.value(), // 403
                "Forbidden",
                ex.getMessage(),
                request.getDescription(false).replace("uri=", ""));
        return new ResponseEntity<>(errorResponse, HttpStatus.FORBIDDEN);
    }

    // 4. Handler genérico para qualquer outro erro (500)
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponseDTO> handleGlobalException(
            Exception ex, WebRequest request) {

        ErrorResponseDTO errorResponse = new ErrorResponseDTO(
                HttpStatus.INTERNAL_SERVER_ERROR.value(), // 500
                "Internal Server Error",
                ex.getMessage(),
                request.getDescription(false).replace("uri=", ""));
        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }
}