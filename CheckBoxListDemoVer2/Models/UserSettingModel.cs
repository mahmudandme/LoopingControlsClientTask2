using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CheckBoxListDemoVer2.Models
{
    public class UserSettingModel
    {
        public int ID { get; set; }
        public string UserControlId { get; set; }
        public string Status { get; set; }
        public int settingNameId { get; set; }

    }
}