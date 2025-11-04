package com.lq.common.model.dto.like;

import lombok.Data;

import java.io.Serializable;

@Data
public class LikeRequest implements Serializable {
    private Long postId;
}