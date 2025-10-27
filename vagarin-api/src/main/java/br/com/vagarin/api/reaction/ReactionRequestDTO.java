package br.com.vagarin.api.reaction;

import lombok.Data;

@Data
public class ReactionRequestDTO {
    // O tipo da reação que o usuário clicou
    private ReactionType type;
}