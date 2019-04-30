package co.yiiu.pybbs;

import co.yiiu.pybbs.model.DocumentLabel;
import co.yiiu.pybbs.service.DocumentCenterService;
import co.yiiu.pybbs.service.DocumentLabelService;
import co.yiiu.pybbs.service.UserService;
import co.yiiu.pybbs.util.FileUtil;
import org.checkerframework.checker.units.qual.A;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = PybbsApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
public class PybbsApplicationTests {
    @Autowired
    private DocumentCenterService documentCenterService;
    @Autowired
    private DocumentLabelService documentLabelService;
    @Test
    public void ArrayAsList(){
//        System.out.println(FileUtil.getFileMd5("/Users/chenghongzhi/GitHub/pybbs/pybbs-db/static/upload/明鉴/路由器/安装/网关安装说明/SpringBoot实战(第4版)清晰版@www.java1234.com-1556604148967.pdf"));
    }

}
