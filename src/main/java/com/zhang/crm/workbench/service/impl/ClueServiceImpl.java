package com.zhang.crm.workbench.service.impl;

import com.zhang.crm.settings.dao.UserDao;
import com.zhang.crm.settings.domain.User;
import com.zhang.crm.utils.DateTimeUtil;
import com.zhang.crm.utils.SqlSessionUtil;
import com.zhang.crm.utils.UUIDUtil;
import com.zhang.crm.vo.PaginationVO;
import com.zhang.crm.workbench.dao.*;
import com.zhang.crm.workbench.domain.*;
import com.zhang.crm.workbench.service.ClueService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class ClueServiceImpl implements ClueService {

    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    private ClueDao clueDao = SqlSessionUtil.getSqlSession().getMapper(ClueDao.class);
    private ClueActivityRelationDao clueActivityRelationDao = SqlSessionUtil.getSqlSession().getMapper(ClueActivityRelationDao.class);
    private ClueRemarkDao clueRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ClueRemarkDao.class);

    private CustomerDao customerDao = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);
    private CustomerRemarkDao customerRemarkDao = SqlSessionUtil.getSqlSession().getMapper(CustomerRemarkDao.class);

    private ContactsDao contactsDao = SqlSessionUtil.getSqlSession().getMapper(ContactsDao.class);
    private ContactsRemarkDao contactsRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ContactsRemarkDao.class);
    private ContactsActivityRelationDao contactsActivityRelationDao = SqlSessionUtil.getSqlSession().getMapper(ContactsActivityRelationDao.class);

    private TranDao tranDao = SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private TranHistoryDao tranHistoryDao = SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);



    @Override
    public boolean save(Clue clue) {
        boolean flag = true;

        int count = clueDao.save(clue);

        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public Clue detail(String id) {
        Clue clue = clueDao.detail(id);
        return clue;
    }

    @Override
    public boolean unbund(String id) {
        boolean flag = true;

        int count = clueActivityRelationDao.unbund(id);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean bund(String clueId, String[] activityIds) {
        boolean flag = true;

        for(String ids : activityIds){
            //取得每一个clueId与ids做关联

            ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
            clueActivityRelation.setId(UUIDUtil.getUUID());
            clueActivityRelation.setClueId(clueId);
            clueActivityRelation.setActivityId(ids);

            //添加关联关系表的记录
            int count = clueActivityRelationDao.bund(clueActivityRelation);

            if(count != 1){
                flag = false;
            }
        }

        return flag;
    }

    @Override
    public boolean convert(String clueId, Tran tran, String createBy) {

        String createTime = DateTimeUtil.getSysTime();

        boolean flag = true;

        //1、通过线索id获取线索对象（线索对象中封装了线索的信息）
        Clue clue = clueDao.getById(clueId);

        //2、通过线索对象提取客户信息，当该客户不存在时，新建客户（根据公司名称精准匹配，判断该客户是否存在）
        //公司名称
        String company = clue.getCompany();

        Customer customer = customerDao.getCustomerByName(company);

        //如果customer为null， 说明以前没有这个客户，需要新建一个
        if(customer == null){
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setAddress(clue.getAddress());
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setOwner(clue.getOwner());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setName(company);
            customer.setDescription(clue.getDescription());
            customer.setCreateTime(createTime);
            customer.setCreateBy(createBy);
            customer.setContactSummary(clue.getContactSummary());

            //添加客户
            int customerCount = customerDao.save(customer);
            if(customerCount != 1){
                flag = false;
            }
        }

        //3、通过线索对象创建联系人信息，保存联系人
        Contacts contacts = new Contacts();
        contacts.setId(UUIDUtil.getUUID());
        contacts.setSource(clue.getSource());
        contacts.setOwner(clue.getOwner());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(clue.getJob());
        contacts.setFullname(clue.getFullname());
        contacts.setEmail(clue.getEmail());
        contacts.setDescription(clue.getDescription());
        contacts.setCustomerId(customer.getId());
        contacts.setCreateTime(createTime);
        contacts.setCreateBy(createBy);
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setAppellation(clue.getAppellation());
        contacts.setAddress(clue.getAddress());

        //添加联系人
        int contactCount = contactsDao.save(contacts);
        if(contactCount != 1){
            flag = false;
        }

        //4、线索备注转换到客户备注，以及联系人备注
        //查询出与该线索关联的备注信息列表
        List<ClueRemark> clueRemarkLists = clueRemarkDao.getListByClueId(clueId);
        for(ClueRemark clueRemark : clueRemarkLists){
            //取出查询出的线索备注信息（备注信息）
            String noteContent = clueRemark.getNoteContent();

            //创建客户备注对象，添加客户备注
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCreateTime(createTime);
            customerRemark.setCreateBy(createBy);
            customerRemark.setCustomerId(customer.getId());
            customerRemark.setEditFlag("0");
            customerRemark.setNoteContent(noteContent);

            int customerRemarkCount = customerRemarkDao.save(customerRemark);
            if(customerRemarkCount != 1){
                flag = false;
            }

            //创建联系人备注对象，创建联系人
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setCreateTime(createTime);
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setContactsId(contacts.getId());
            contactsRemark.setEditFlag("0");
            contactsRemark.setNoteContent(noteContent);
            int contactsRemarkCount = contactsRemarkDao.save(contactsRemark);
            if(contactsRemarkCount != 1){
                flag = false;
            }




        }

        //5、“线索与市场活动”的关系转换到“联系人和市场活动”的关系

        //查询出与该条线索关联的市场活动，查询与市场活动的关联关系列表
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationDao.getListClueId(clueId);
        for(ClueActivityRelation clueActivityRelation :clueActivityRelations){
            //从每一条遍历出来的记录中取出市场活动的ID
            String activityId = clueActivityRelation.getActivityId();

            //创建联系人与市场活动的关联关系对象，让第三步生成的联系人与市场活动做关联
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setActivityId(activityId);
            contactsActivityRelation.setContactsId(contacts.getId());

            //添加联系人与市场活动的关联关系
            int contactsActivityRelationCount = contactsActivityRelationDao.save(contactsActivityRelation);
            if(contactsActivityRelationCount != 1){
                flag = false;
            }

        }

        //6、如果有创建交易的需求。创建一条交易
        if(tran != null){

            // tran对象在controller里面以及封装好了的信息有：
            // id, money, name, expectedDate, stage, activityId,createBy, createTime

            //接下来通过第一步生成的clue对象，取出信息，继续完善tran信息的封装

            tran.setSource(clue.getSource());
            tran.setOwner(clue.getOwner());
            tran.setNextContactTime(clue.getNextContactTime());
            tran.setDescription(clue.getDescription());
            tran.setCustomerId(customer.getId());
            tran.setContactSummary(clue.getContactSummary());
            tran.setContactsId(contacts.getId());

            //添加交易
            int tranCount = tranDao.save(tran);
            if(tranCount != 1){
                flag = false;
            }


            //7、如果创建了交易，则创建一条该交易的交易历史
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(UUIDUtil.getUUID());
            tranHistory.setCreateTime(createTime);
            tranHistory.setCreateBy(createBy);
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setStage(tran.getStage());
            tranHistory.setTranId(tran.getId());
            //添加交易历史
            int tranHistoryCount = tranHistoryDao.save(tranHistory);
            if(tranHistoryCount != 1){
                flag = false;
            }
        }

        //8、删除线索备注
        for(ClueRemark clueRemark : clueRemarkLists){

            int deleteClueRemarkCount = clueRemarkDao.delete(clueRemark);
            if(deleteClueRemarkCount != 1){
                flag = false;
            }


        }

        //9、删除线索与市场活动的关联关系
        for(ClueActivityRelation clueActivityRelation :clueActivityRelations){
            int deleteClueActivityRelationCount =  clueActivityRelationDao.delete(clueActivityRelation);
            if(deleteClueActivityRelationCount != 1){
                flag = false;
            }
        }

        //10、删除线索
        int count = clueDao.delete(clueId);
        if(count != 1){
            flag = false;
        }



        return flag;
    }

    @Override
    public PaginationVO<Clue> pageList(Map<String, Object> map) {
        //计算total
        int total = clueDao.getTotalByCondition(map);

        //取得dataList
        List<Clue> dataList = clueDao.getClueListByCondition(map);

        //将total和dataList封装到VO中返回
        PaginationVO<Clue> cluePaginationVO = new PaginationVO<>();
        cluePaginationVO.setTotal(total);
        cluePaginationVO.setDataList(dataList);

        return cluePaginationVO;
    }

    @Override
    public boolean deleteClueListInfo(String[] ids) {
        boolean flag = true;

        int queryRelationCount = clueActivityRelationDao.getRelationCountByClueIds(ids);

        //删除对应的市场活动与线索的关系
        int activityAndClueRelation = clueActivityRelationDao.deleteRelationByClueIds(ids);

        if(queryRelationCount != activityAndClueRelation){
            flag = false;
        }

        //先查询出需要删除的备注数量
        int queryRemarkCount = clueRemarkDao.getRemarkCountByClueids(ids);

        //删除备注，受到返回影响的条数（实际删除的数量）
        int deleteCount = clueRemarkDao.deleteByClueids(ids);

        if(queryRemarkCount != deleteCount){
            flag = false;
        }

        // 删除市场活动
        int count = clueDao.deleteClue(ids);
        if(count != ids.length){
            flag = false;
        }

        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndClue(String id) {

        List<User> uList = userDao.getUserList();

        Clue clue = clueDao.getById(id);

        Map<String,Object> map = new HashMap<>();
        map.put("uList",uList);
        map.put("c",clue);

        return map;
    }

    @Override
    public boolean updateClueList(Clue clue) {
        boolean flag = true;

        int count = clueDao.updateClueList(clue);
        if(count != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public boolean deleteRemarkInfo(String id) {
        boolean flag = true;

        int count = clueRemarkDao.deleteRemarkInfo(id);
        if(count != 1){
            flag = false;
        }
        return flag;
    }

    @Override
    public boolean saveRemarkInfo(ClueRemark clueRemark) {
        boolean flag = true;

        int count = clueRemarkDao.saveRemarkInfo(clueRemark);
        if(count != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public List<ClueRemark> getRemarkListByClueId(String clueId) {

        List<ClueRemark> clueRemarks = clueRemarkDao.getRemarkListByClueId(clueId);

        return clueRemarks;
    }


}
