package com.example.${module}.controller.admin;

import com.example.server.dto.${Domain}Dto;
import com.example.server.dto.PageDto;
import com.example.server.dto.ResponseDto;
import com.example.server.service.${Domain}Service;
import com.example.server.util.ValidatorUtil;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

@RestController
@RequestMapping("/admin/${domain}")
public class ${Domain}Controller {

    @Resource
    private ${Domain}Service ${domain}Service;
    private static final String BUSINESS_NAME = "${tableNameCn}";

    @PostMapping("/list")
    public ResponseDto list(@RequestBody PageDto pageDto) {
        ${domain}Service.list(pageDto);
        ResponseDto responseDto = new ResponseDto();
        responseDto.setContent(pageDto);
        return responseDto;
    }

    @PostMapping("/save")
    public ResponseDto save(@RequestBody ${Domain}Dto ${domain}Dto) {
        // 保存校验
        ${domain}Service.save(${domain}Dto);
        ResponseDto responseDto = new ResponseDto();
        responseDto.setContent(${domain}Dto);
        return responseDto;
    }

    @DeleteMapping("/delete/{id}")
    public ResponseDto delete(@PathVariable String id) {
        ResponseDto responseDto = new ResponseDto();
        ${domain}Service.delete(id);
        return responseDto;
    }

}
