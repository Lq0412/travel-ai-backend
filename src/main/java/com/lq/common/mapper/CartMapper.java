package com.lq.common.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lq.common.model.entity.Cart;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CartMapper extends BaseMapper<Cart> {
}

