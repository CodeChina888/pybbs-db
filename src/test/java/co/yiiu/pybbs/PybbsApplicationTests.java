package co.yiiu.pybbs;

import co.yiiu.pybbs.model.DocumentLabel;
import co.yiiu.pybbs.service.DocumentCenterService;
import co.yiiu.pybbs.service.DocumentLabelService;
import co.yiiu.pybbs.service.PermissionService;
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
    private PermissionService permissionService;
    @Test
    public void ArrayAsList(){
        permissionService.delete(81);
    }

}
