package com.lq.common.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lq.common.AI.core.model.dto.ResponseDTO;
import com.lq.common.common.DeleteRequest;
import com.lq.common.common.ResponseUtils;
import com.lq.common.constant.UserConstant;
import com.lq.common.exception.BusinessException;
import com.lq.common.exception.ErrorCode;
import com.lq.common.exception.ThrowUtils;
import com.lq.common.model.dto.user.*;
import com.lq.common.model.entity.User;
import com.lq.common.model.vo.LoginUserVO;
import com.lq.common.model.vo.UserVO;
import com.lq.common.service.UserService;
import com.lq.common.annotation.AuthCheck;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.BeanUtils;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * 用户管理接口
 * 提供用户注册、登录、注销、增删改查等功能
 *
 * @author Lq304
 * @createDate 2025-08-20
 */
@RestController
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    // 1. 用户注册
    @PostMapping("/register")
//    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public ResponseDTO<Long> userRegister(@RequestBody UserRegisterRequest userRegisterRequest) {
        // 1. 参数校验
        ThrowUtils.throwIf(userRegisterRequest == null, ErrorCode.PARAMS_ERROR);
        String userAccount = userRegisterRequest.getUserAccount();
        String userPassword = userRegisterRequest.getUserPassword();
        String checkPassword = userRegisterRequest.getCheckPassword();
        
        // 2. 执行注册
        long result = userService.userRegister(userAccount, userPassword, checkPassword);
        return ResponseUtils.success(result);
    }

    // 2. 用户登录
    @PostMapping("/login")
    public ResponseDTO<LoginUserVO> userLogin(@RequestBody UserLoginRequest userLoginRequest, HttpServletRequest request) {
        // 1. 参数校验
        ThrowUtils.throwIf(userLoginRequest == null, ErrorCode.PARAMS_ERROR);
        String userAccount = userLoginRequest.getUserAccount();
        String userPassword = userLoginRequest.getUserPassword();
        
        // 2. 执行登录
        LoginUserVO loginUserVO = userService.userLogin(userAccount, userPassword, request);
        return ResponseUtils.success(loginUserVO);
    }

    // 3. 获取当前登录用户信息
    @GetMapping("/get/login")
    public ResponseDTO<LoginUserVO> getLoginUser(HttpServletRequest request) {
        // 1. 获取登录用户
        User loginUserVO = userService.getLoginUser(request);
        
        // 2. 转换为封装类并返回
        return ResponseUtils.success(userService.getLoginUserVO(loginUserVO));
    }

    // 4. 用户注销
    @PostMapping("/logout")
    public ResponseDTO<Boolean> userLogout(HttpServletRequest request) {
        // 1. 参数校验
        ThrowUtils.throwIf(request == null, ErrorCode.OPERATION_ERROR);
        
        // 2. 执行注销
        boolean result = userService.userLogout(request);
        return ResponseUtils.success(result);
    }

    // 5. 创建用户（仅管理员）
    @PostMapping("/add")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public ResponseDTO<Long> addUser(@RequestBody UserAddRequest userAddRequest) {
        // 1. 参数校验
        ThrowUtils.throwIf(userAddRequest == null, ErrorCode.PARAMS_ERROR);
        
        // 2. DTO转实体对象
        User user = new User();
        BeanUtils.copyProperties(userAddRequest, user);
        
        // 3. 设置默认密码
        final String DEFAULT_PASSWORD = "12345678";
        String encryptPassword = userService.getEncryptPassword(DEFAULT_PASSWORD);
        user.setUserPassword(encryptPassword);
        
        // 4. 保存用户
        boolean result = userService.save(user);
        ThrowUtils.throwIf(!result, ErrorCode.OPERATION_ERROR);
        return ResponseUtils.success(user.getId());
    }

    // 6. 根据ID获取用户详情（仅管理员）
    @GetMapping("/get")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public ResponseDTO<User> getUserById(long id) {
        // 1. 参数校验
        ThrowUtils.throwIf(id <= 0, ErrorCode.PARAMS_ERROR);
        
        // 2. 查询用户信息
        User user = userService.getById(id);
        ThrowUtils.throwIf(user == null, ErrorCode.NOT_FOUND_ERROR);
        return ResponseUtils.success(user);
    }

    // 7. 根据ID获取用户详情（封装类）
    @GetMapping("/get/vo")
    public ResponseDTO<UserVO> getUserVOById(long id) {
        // 1. 获取用户信息
        ResponseDTO<User> response = getUserById(id);
        User user = response.getData();
        
        // 2. 转换为封装类并返回
        return ResponseUtils.success(userService.getUserVO(user));
    }

    // 8. 删除用户（仅管理员）
    @PostMapping("/delete")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public ResponseDTO<Boolean> deleteUser(@RequestBody DeleteRequest deleteRequest) {
        // 1. 参数校验
        if (deleteRequest == null || deleteRequest.getId() <= 0) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        
        // 2. 执行删除
        boolean b = userService.removeById(deleteRequest.getId());
        return ResponseUtils.success(b);
    }

    // 9. 更新用户信息（仅管理员）
    @PostMapping("/update")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public ResponseDTO<Boolean> updateUser(@RequestBody UserUpdateRequest userUpdateRequest) {
        // 1. 参数校验
        if (userUpdateRequest == null || userUpdateRequest.getId() == null) {
            throw new BusinessException(ErrorCode.PARAMS_ERROR);
        }
        
        // 2. DTO转实体对象
        User user = new User();
        BeanUtils.copyProperties(userUpdateRequest, user);
        
        // 3. 执行更新
        boolean result = userService.updateById(user);
        ThrowUtils.throwIf(!result, ErrorCode.OPERATION_ERROR);
        return ResponseUtils.success(true);
    }

    // 10. 分页获取用户列表（仅管理员）
    @PostMapping("/list/page/vo")
    @AuthCheck(mustRole = UserConstant.ADMIN_ROLE)
    public ResponseDTO<Page<UserVO>> listUserVOByPage(@RequestBody UserQueryRequest userQueryRequest) {
        // 1. 参数校验
        ThrowUtils.throwIf(userQueryRequest == null, ErrorCode.PARAMS_ERROR);
        
        // 2. 提取分页参数
        long current = userQueryRequest.getCurrent();
        long pageSize = userQueryRequest.getPageSize();
        
        // 3. 执行分页查询
        Page<User> userPage = userService.page(new Page<>(current, pageSize),
                userService.getQueryWrapper(userQueryRequest));
        
        // 4. 转换为封装类
        Page<UserVO> userVOPage = new Page<>(current, pageSize, userPage.getTotal());
        List<UserVO> userVOList = userService.getUserVOList(userPage.getRecords());
        userVOPage.setRecords(userVOList);
        return ResponseUtils.success(userVOPage);
    }
}
