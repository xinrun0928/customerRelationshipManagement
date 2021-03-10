package crm.settings;

import com.zhang.crm.exception.LoginException;
import com.zhang.crm.utils.DateTimeUtil;
import com.zhang.crm.utils.MD5Util;
import com.zhang.crm.utils.SqlSessionUtil;
import com.zhang.crm.workbench.dao.TranDao;
import com.zhang.crm.workbench.domain.Tran;
import com.zhang.crm.workbench.service.TranService;
import org.junit.Test;

public class MyTest {

    @Test
    public void currentTime(){
        String currentTime = DateTimeUtil.getSysTime();
        System.out.println(currentTime);
    }

    @Test
    public void md5AddPassword(){
        String password = "zhangxinrun";
        String addPassword = MD5Util.getMD5(password);
        System.out.println(addPassword);
    }

    @Test
    public void myException(){
        LoginException loginException = new LoginException("登录异常");
        String message = loginException.getMessage();
        System.out.println(message);
    }

    @Test
    public void myStringArr(){
//        TranDao tranDao = SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
//        String[] name = tranDao.getStages();
//        System.out.println(name);
    }
}
