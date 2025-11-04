package com.lq.common.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lq.common.model.entity.Tag;

import java.util.List;

public interface TagService extends IService<Tag> {

    List<Tag> getTagsByPostId(Long postId);

    List<Tag> searchTags(String keyword);

    List<Tag> createOrGetTags(List<String> tagNames);

    void updatePostTags(Long postId, List<String> tagNames);
}