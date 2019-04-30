package co.yiiu.pybbs.service;

import co.yiiu.pybbs.mapper.DocumentLabelMapper;
import co.yiiu.pybbs.model.DocumentLabel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class DocumentLabelService {
    @Autowired
    private DocumentLabelMapper documentLabelMapper;

    public void insert(List<DocumentLabel> labels){
        documentLabelMapper.insertForEach(labels);
    }

    public void deleteLabelById(Integer id){
        documentLabelMapper.deleteLabelById(id);
    }
}
