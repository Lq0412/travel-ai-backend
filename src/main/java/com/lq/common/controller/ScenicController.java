package com.lq.common.controller;

import com.lq.common.AI.core.model.dto.ResponseDTO;
import com.lq.common.common.ResponseUtils;
import com.lq.common.model.entity.ScenicSpot;
import com.lq.common.service.ScenicSpotService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/scenic")
public class ScenicController {

    @Resource
    private ScenicSpotService scenicSpotService;

    /**
     * 获取所有景点列表
     */
    @GetMapping("/list")
    public ResponseDTO<List<ScenicSpot>> listSpots() {
        try {
            List<ScenicSpot> spots = scenicSpotService.getAllSpots();
            return ResponseUtils.success(spots != null ? spots : List.of());
        } catch (Exception e) {
            log.error("获取景点列表失败", e);
            return ResponseUtils.error(500, "获取景点列表失败");
        }
    }

    /**
     * 获取景点详情
     */
    @GetMapping("/{id}")
    public ResponseDTO<ScenicSpot> getScenicDetail(@PathVariable Long id) {
        if (id == null || id <= 0) {
            return ResponseUtils.error(400, "景点ID无效");
        }
        
        try {
            ScenicSpot spot = scenicSpotService.getById(id);
            if (spot == null || spot.getIsDelete() == 1) {
                return ResponseUtils.error(404, "景点不存在");
            }
            return ResponseUtils.success(spot);
        } catch (Exception e) {
            log.error("获取景点详情失败", e);
            return ResponseUtils.error(500, "获取景点详情失败");
        }
    }
}

