package br.com.vagarin.api.comment;

import br.com.vagarin.api.post.Post;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    // Lista os comentários de um post, do mais antigo para o mais novo
    List<Comment> findByPostOrderByCreatedAtAsc(Post post);
}