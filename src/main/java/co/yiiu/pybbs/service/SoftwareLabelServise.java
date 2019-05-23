package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.SoftwareLabelMapper;
import co.yiiu.pybbs.mapper.SoftwareMapper;
import co.yiiu.pybbs.model.*;
//import com.google.gson.JsonObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Transactional
@Service
public class SoftwareLabelServise
{
    @Autowired
    private SoftwareLabelMapper softwareLabelMapper;
    @Autowired
    private LabelService labelService;
    @Autowired
    private UserService userService;
    @Autowired
    private SoftwareMapper softwareMapper;


    public void insert(List<SoftwareLabel> softwareLabel){
        softwareLabelMapper.insertForEach(softwareLabel);
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

    public void delete(Integer softwareId){
        softwareLabelMapper.deleteLabelById(softwareId);
    }

    public List softLabels(Integer softId){
        QueryWrapper<SoftwareLabel> wrapper = new QueryWrapper<>();
        wrapper.eq("file_id",softId);
        return softwareLabelMapper.selectList(wrapper);
    }
}
