package com.lq.common.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.lq.common.annotation.AuthCheck;
import com.lq.common.AI.core.model.dto.ResponseDTO;
import com.lq.common.common.ResponseUtils;
import com.lq.common.constant.UserConstant;
import com.lq.common.model.dto.order.CreateOrderRequest;
import com.lq.common.model.entity.Order;
import com.lq.common.model.entity.OrderItem;
import com.lq.common.service.OrderService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/orders")
public class OrderController {

    @Resource
    private OrderService orderService;

    @PostMapping("/create")
    public ResponseDTO<Long> createOrder(@RequestBody CreateOrderRequest request, HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.createOrder(request, httpRequest));
    }

    @GetMapping("/my")
    public ResponseDTO<IPage<Order>> listMyOrders(@RequestParam(defaultValue = "1") long current,
                                                   @RequestParam(defaultValue = "10") long size,
                                                   HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.listMyOrders(current, size, httpRequest));
    }

    @GetMapping("/my/{orderId}")
    public ResponseDTO<Order> getMyOrderDetail(@PathVariable Long orderId, HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.getMyOrderDetail(orderId, httpRequest));
    }

    @GetMapping("/{orderId}/items")
    public ResponseDTO<List<OrderItem>> listOrderItems(@PathVariable Long orderId) {
        return ResponseUtils.success(orderService.listOrderItems(orderId));
    }

    @PostMapping("/pay")
    public ResponseDTO<Boolean> payOrder(@RequestParam Long orderId,
                                          @RequestParam Integer payMethod,
                                          HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.payOrder(orderId, payMethod, httpRequest));
    }

    @PostMapping("/cancel")
    public ResponseDTO<Boolean> cancelOrder(@RequestParam Long orderId,
                                             @RequestParam(required = false) String reason,
                                             HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.cancelOrder(orderId, reason, httpRequest));
    }

    // ================= 商家端接口 =================

    @GetMapping("/merchant/list")
    @AuthCheck(mustRole = UserConstant.MERCHANT_ROLE)
    public ResponseDTO<IPage<Order>> listMerchantOrders(@RequestParam(defaultValue = "1") long current,
                                                          @RequestParam(defaultValue = "10") long size,
                                                          @RequestParam(required = false) String orderNo,
                                                          @RequestParam(required = false) Integer status,
                                                          HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.listMerchantOrders(current, size, orderNo, status, httpRequest));
    }

    @GetMapping("/merchant/{orderId}")
    @AuthCheck(mustRole = UserConstant.MERCHANT_ROLE)
    public ResponseDTO<Order> getMerchantOrderDetail(@PathVariable Long orderId, HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.getMerchantOrderDetail(orderId, httpRequest));
    }

    @PostMapping("/merchant/{orderId}/ship")
    @AuthCheck(mustRole = UserConstant.MERCHANT_ROLE)
    public ResponseDTO<Boolean> shipOrder(@PathVariable Long orderId,
                                          @RequestParam(required = false) String trackingNumber,
                                          HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.shipOrder(orderId, trackingNumber, httpRequest));
    }

    @PostMapping("/merchant/{orderId}/cancel")
    @AuthCheck(mustRole = UserConstant.MERCHANT_ROLE)
    public ResponseDTO<Boolean> merchantCancelOrder(@PathVariable Long orderId,
                                                     @RequestParam(required = false) String reason,
                                                     HttpServletRequest httpRequest) {
        return ResponseUtils.success(orderService.merchantCancelOrder(orderId, reason, httpRequest));
    }
}


