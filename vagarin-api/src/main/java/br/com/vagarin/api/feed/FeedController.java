package br.com.vagarin.api.feed;

import br.com.vagarin.api.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDate;

@RestController
@RequestMapping("/api/v1/feed")
public class FeedController {

    @Autowired
    private FeedService feedService;

    /**
     * Endpoint principal da Home
     * Ex: /api/v1/feed/daily?date=2025-10-27
     */
    @GetMapping("/daily")
    public ResponseEntity<HomeFeedResponseDTO> getDailyFeed(
            @AuthenticationPrincipal User currentUser,
            @RequestParam("date") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {

        // (O GlobalExceptionHandler cuida dos erros)
        HomeFeedResponseDTO feed = feedService.getHomeFeed(currentUser, date);
        return ResponseEntity.ok(feed);
    }
}