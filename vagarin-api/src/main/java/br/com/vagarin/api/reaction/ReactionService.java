package br.com.vagarin.api.reaction;

import br.com.vagarin.api.exception.ResourceNotFoundException;
import br.com.vagarin.api.post.Post;
import br.com.vagarin.api.post.PostRepository;
import br.com.vagarin.api.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class ReactionService {

    @Autowired
    private ReactionRepository reactionRepository;

    @Autowired
    private PostRepository postRepository;

    /**
     * Lógica principal de "TOGGLE" (Adicionar ou Remover) uma reação
     */
    public ReactionSummaryDTO toggleReaction(User currentUser, Long postId, ReactionType reactionType) {

        // 1. Acha o Post
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Post não encontrado"));

        // 2. Procura se ESSA reação (mesmo user, post e tipo) já existe
        Optional<Reaction> existingReaction = reactionRepository.findByUserAndPostAndType(
                currentUser,
                post,
                reactionType);

        if (existingReaction.isPresent()) {
            // 3a. JÁ EXISTE: O usuário clicou de novo, então remove (Toggle Off)
            reactionRepository.delete(existingReaction.get());
        } else {
            // 3b. NÃO EXISTE: Cria a nova reação (Toggle On)
            Reaction newReaction = new Reaction(null, currentUser, post, reactionType);
            reactionRepository.save(newReaction);
        }

        // 4. Retorna o novo resumo atualizado de reações do post
        return getReactionSummary(currentUser, post);
    }

    /**
     * Lógica para LER o resumo de reações de um post
     */
    public ReactionSummaryDTO getReactionSummary(User currentUser, Long postId) {
        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new ResourceNotFoundException("Post não encontrado"));

        return getReactionSummary(currentUser, post); // Chama o helper
    }

    /**
     * Helper privado que faz a contagem
     */
    private ReactionSummaryDTO getReactionSummary(User currentUser, Post post) {

        // 1. Pega todas as reações do post de uma vez
        List<Reaction> allReactions = reactionRepository.findByPost(post);

        // 2. CONTAGEM TOTAL: Agrupa as reações por TIPO e conta quantas tem em cada
        // grupo
        Map<ReactionType, Long> counts = allReactions.stream()
                .collect(Collectors.groupingBy(
                        Reaction::getType,
                        Collectors.counting()));

        // 3. MINHAS REAÇÕES: Filtra a lista para pegar só as do usuário logado
        List<ReactionType> myReactions = allReactions.stream()
                .filter(r -> r.getUser().getId().equals(currentUser.getId()))
                .map(Reaction::getType)
                .collect(Collectors.toList());

        // 4. Retorna o DTO de resumo
        return new ReactionSummaryDTO(counts, myReactions);
    }
}