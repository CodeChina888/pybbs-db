package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.FileLabelMapper;
import co.yiiu.pybbs.mapper.UploadFileMapper;
import co.yiiu.pybbs.model.*;
import co.yiiu.pybbs.util.HttpClientUtil;
import co.yiiu.pybbs.util.JsonUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
//import com.google.gson.JsonObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.google.gson.reflect.TypeToken;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.lang.reflect.Type;
import java.util.*;

@Transactional
@Service
public class FileLabelServise
{
    @Autowired
    private FileLabelMapper fileLabelMapper;
    @Autowired
    private LabelService labelService;
    @Autowired
    private UserService userService;
    @Autowired
    private UploadFileMapper uploadFileMapper;


    public void insert(int fileId,Integer labelId){
        FileLabel fileLabel=new FileLabel();
        fileLabel.setFileId(fileId);
        fileLabel.setLabelId(labelId);
        fileLabelMapper.insert(fileLabel);
    }


    public Boolean hasLabel(Integer userId,Integer softLabelId){
        List listUserLabel=userService.getUserLabel(userId);
        List listFileLabel=labelService.SelectAllBySoftId(softLabelId);
        Boolean has=false;
        for (int i=0;i<listUserLabel.size();i++){
            for (int j=0;j<listFileLabel.size();j++){
                    if (listUserLabel.get(i).equals(listFileLabel.get(j))){
                        has=true;
                    }
            }
        }
        return has;
    }

    public void delete(Integer fileId){
        uploadFileMapper.deleteLabelRelation(fileId);
    }

    public List softLabels(Integer softId){
        QueryWrapper<FileLabel> wrapper = new QueryWrapper<>();
        wrapper.eq("file_id",softId);
        return fileLabelMapper.selectList(wrapper);
    }
}
