
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.whut_vaccine.domain.Vaccine;
import com.whut_vaccine.service.AdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
//管理员管理疫苗
@Controller
@RequestMapping("/admin")
public class AdminController {
    @Autowired
    private AdminService adminService;
    //显示数据库中疫苗信息
    @RequestMapping(value = "/show", method = RequestMethod.GET)
    @ResponseBody
    public List<Vaccine> show(HttpServletRequest request, HttpServletResponse respone) {
        List<Vaccine> vaccineslist = adminService.ShowAll();
        return vaccineslist;
    }
    //增删改数据库中疫苗信息
    @RequestMapping(value = "/changeVaccine", method = RequestMethod.POST)
    @ResponseBody
    public String changVaccine(@RequestBody JSONObject jsonObject){

        try {
            String flag="none";
            int flagAdd=0;
            int flagDel=0;
            JSONArray del = jsonObject.getJSONArray("delete");
            JSONArray add = jsonObject.getJSONArray("add");
            //删除修改疫苗

            if (del != null) {
                for (int i = 0; i < del.size(); i++) {
                    adminService.DeleteVaccine(Integer.parseInt(String.valueOf(del.getIntValue(i))));
                    flagDel++;
                }
            }

            //增加疫苗
            try{
                if (add != null) {
                    for (int i = 0; i < add.size(); i++) {
                        JSONObject temp = add.getJSONObject(i);
                        Integer id = Integer.parseInt((String) temp.get("id"));
                        String vaccinename = (String) temp.get("vaccinename");
                        String makeday = (String) temp.get("makeday");
                        Double price = Double.parseDouble ((String)temp.get("price"));
                        String introduce = (String) temp.get("introduce");
                        String keepday = (String) temp.get("keepday");
                        Integer pnumber = Integer.parseInt((String) temp.get("pnumber"));
                        if (id == null || makeday == "" || keepday == "" || vaccinename == "" ||introduce == "" ) {
                            return "invalid";
                        } else {
                            pnumber = (pnumber == null) ? 0 : pnumber;
                            Vaccine vaccine = new Vaccine(id, makeday, keepday, vaccinename,price,introduce,pnumber);
                            adminService.InsertVaccine(vaccine);
                            flagAdd++;
                        }
                    }
                }
            }catch (Exception e){
                return "have";
            }
            if(flagAdd!=0||flagDel!=0){
                flag=flagAdd+"."+flagDel;
            }
            return flag;

        }catch (Exception e) {
            return "404";
        }
    }
}
