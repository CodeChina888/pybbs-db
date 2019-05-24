package co.yiiu.pybbs;

import co.yiiu.pybbs.model.Category;
import co.yiiu.pybbs.model.Document;
import co.yiiu.pybbs.model.DocumentLabel;
import co.yiiu.pybbs.model.Software;
import co.yiiu.pybbs.service.*;
import co.yiiu.pybbs.util.FileUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.checkerframework.checker.units.qual.A;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.*;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = PybbsApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class PybbsApplicationTests {

    @Autowired
    private CategoryService categoryService;
    @Autowired
    private SoftwareService softwareService;
    @Autowired
    private DocumentCenterService documentCenterService;
    @Test
    public void ArrayAsList(){
        IPage<Document> page =documentCenterService.selectAll(1,"java");
        for (Document software:page.getRecords()){
            System.out.println(software.getOriginName());
        }

    }

}
