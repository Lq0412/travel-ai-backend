package com.lq.common.service;

import com.lq.common.model.entity.User;

public interface CommentLikeService {
    void likeComment(Long commentId, User loginUser);
    void unlikeComment(Long commentId, User loginUser);
    boolean isCommentLiked(Long commentId, Long userId);
}