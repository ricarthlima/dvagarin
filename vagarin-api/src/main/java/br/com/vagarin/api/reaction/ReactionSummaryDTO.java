package br.com.vagarin.api.reaction;

import lombok.Data;
import java.util.List;
import java.util.Map;

@Data
public class ReactionSummaryDTO {

    // Ex: { "LOVE": 5, "INTERESTING": 2 }
    private Map<ReactionType, Long> counts;

    // Ex: [ "LOVE", "INTERESTING" ]
    private List<ReactionType> myReactions;

    public ReactionSummaryDTO(Map<ReactionType, Long> counts, List<ReactionType> myReactions) {
        this.counts = counts;
        this.myReactions = myReactions;
    }
}