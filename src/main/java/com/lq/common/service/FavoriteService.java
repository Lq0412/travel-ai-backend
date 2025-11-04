package com.lq.common.service;

import com.lq.common.model.entity.User;

public interface FavoriteService {
    void addFavorite(Long postId, User loginUser);
    void removeFavorite(Long postId, User loginUser);
    boolean isFavorited(Long postId, Long userId);
}