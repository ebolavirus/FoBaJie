//
//  GuanyuViewController.m
//  BlueTDevice
//
//  Created by MingmingSun on 16/10/5.
//  Copyright © 2016年 Sunmingming. All rights reserved.
//

#import "GuanyuViewController.h"
#import "AppDelegate.h"
#import <Masonry.h>

@interface GuanyuViewController ()

@property(nonatomic,strong) UITextView *myTextview;

@end

@implementation GuanyuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.myTextview = [UITextView new];
        self.myTextview.editable = NO;
        self.myTextview.selectable = NO;
        [self.view addSubview:self.myTextview];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"声明";
    self.myTextview.text = @"欢迎你使用许愿树软件及服务！\n为使用许愿树软件（以下简称“本软件”）及服务，你应当阅读并遵守《许愿树软件许可及服务协议》（以下简称“本协议”）。请你务必审慎阅读、充分理解各条款内容，特别是免除或者限制责任的条款，以及开通或使用某项服务的单独协议，并选择接受或不接受。限制、免责条款可能以加粗形式提示您注意。\n除非您已阅读并接受本协议所有条款，否则你无权下载、安装或使用本软件及相关服务。你的下载、安装、使用、获取许愿树帐号、登录等行为即视为你已阅读并同意上述协议的约束。\n一、协议的范围\n1.1 协议适用主体范围\n本协议是你与许愿树软件之间关于你下载、安装、使用、复制本软件，以及使用本软件相关服务所订立的协议。\n1.2 协议关系及冲突条款\n本协议内容同时包括上海市小萝莉科技有限公司可能不断发布的关于本服务的相关协议、业务规则等内容。上述内容一经正式发布，即为本协议不可分割的组成部分，您同样应当遵守。\n二、关于本服务\n2.1 本服务的内容\n本服务内容是指许愿树软件向用户提供的美容美发预定、支付、评论等信息通知服务，支持定位、晒单、优惠券信息发送、订单信息查询服务，同时为美发师提供包括但不限于订单信息查询、回复评论等功能或内容的软件许可及服务（以下简称“本服务”）。\n2.2 本服务的形式\n2.2.1 你使用本服务需要下载许愿树客户端软件，本软件给予你一项个人的、不可转让及非排他性的许可。你仅可为访问或使用本服务的目的而使用这些软件及服务。\n2.3 本服务许可的范围\n2.3.1 本条及本协议其他条款未明示授权的其他一切权利仍由上海市小萝莉科技有限公司保留，你在行使这些权利时须另外取得上海市小萝莉科技有限公司的书面许可。上海市小萝莉科技有限公司如果未行使前述任何权利，并不构成对该权利的放弃。\n三、用户个人信息保护\n3.1 保护用户个人信息是上海市小萝莉科技有限公司的一项基本原则，本软件将会采取合理的措施保护用户的个人信息。除法律法规规定的情形外，未经用户许可上海市小萝莉科技有限公司不会向第三方公开、透露用户个人信息。\n3.2 未经你的同意，本软件不会向上海市小萝莉科技有限公司以外的任何公司、组织和个人披露你的个人信息，但法律法规另有规定的除外。\n四、用户行为规范\n4.1 信息内容规范\n4.1.1 本条所述信息内容是指用户使用本软件及服务过程中所制作、复制、发布、传播的任何内容，包括但不限于帐号头像、名字、用户说明等注册信息，或文字、语音、图片等发送、回复、图文和相关链接页面，以及其他使用帐号或本软件及服务所产生的内容。\n4.1.2 你理解并同意，许愿树软件一直致力于为用户提供文明健康、规范有序的网络环境，你不得利用本软件帐号或本软件及服务制作、复制、发布、传播如下干扰许愿树软件正常运营，以及侵犯其他用户或第三方合法权益的内容，包括但不限于：\n4.1.2.1 发布、传送、传播、储存违反国家法律法规禁止的内容：\n（1）违反宪法确定的基本原则的；\n（2）危害国家安全，泄露国家秘密，颠覆国家政权，破坏国家统一的；\n（3）损害国家荣誉和利益的；\n（4）煽动民族仇恨、民族歧视，破坏民族团结的；\n（5）破坏国家宗教政策，宣扬邪教和封建迷信的；\n（6）散布谣言，扰乱社会秩序，破坏社会稳定的；\n（7）散布淫秽、色情、赌博、暴力、恐怖或者教唆犯罪的；\n（8）侮辱或者诽谤他人，侵害他人合法权益的；\n（9）煽动非法集会、结社、游行、示威、聚众扰乱社会秩序；\n（10）以非法民间组织名义活动的；\n（11）不符合《即时通信工具公众信息服务发展管理暂行规定》及遵守法律法规、社会主义制度、国家利益、公民合法利益、公共秩序、社会道德风尚和信息真实性等“七条底线”要求的；\n（12）含有法律、行政法规禁止的其他内容的。\n4.1.2.2 发布、传送、传播、储存侵害他人名誉权、肖像权、知识产权、商业秘密等合法权利的内容；\n4.1.2.3 涉及他人隐私、个人信息或资料的；\n4.1.2.4 发表、传送、传播骚扰、信息及垃圾信息或含有任何性或性暗示的；\n4.1.2.5 其他违反法律法规、政策及公序良俗、社会公德或干扰许愿树正常运营和侵犯其他用户或第三方合法权益内容的信息。\n4.2 软件使用规范\n除非法律允许或上海市小萝莉科技有限公司书面许可，你使用本软件过程中不得从事下列行为：\n4.2.1 删除本软件及其副本上关于著作权的信息；\n4.2.2 对本软件进行反向工程、反向汇编、反向编译，或者以其他方式尝试发现本软件的源代码；\n4.2.3 对上海市小萝莉科技有限公司拥有知识产权的内容进行使用、出租、出借、复制、修改、链接、转载、汇编、发表、出版、建立镜像站点等；\n4.2.4 对本软件或者本软件运行过程中释放到任何终端内存中的数据、软件运行过程中客户端与服务器端的交互数据，以及本软件运行所必需的系统数据，进行复制、修改、增加、删除、挂接运行或创作任何衍生作品，形式包括但不限于使用插件、外挂或非上海市小萝莉科技有限公司的第三方工具/服务接入本软件和相关系统；\n4.2.5 通过修改或伪造软件运行中的指令、数据，增加、删减、变动软件的功能或运行效果，或者将用于上述用途的软件、方法进行运营或向公众传播，无论这些行为是否为商业目的；\n4.2.6 通过非上海市小萝莉科技有限公司开发、授权的第三方软件、插件、外挂、系统，登录或使用许愿树软件及服务，或制作、发布、传播上述工具；\n4.2.7 自行或者授权他人、第三方软件对本软件及其组件、模块、数据进行干扰；\n4.2.8 其他未经本软件明示授权的行为。\n五、知识产权声明\n5.1 上海市小萝莉科技有限公司是本软件的知识产权权利人。本软件的一切著作权、商标权、专利权、商业秘密等知识产权，以及与本软件相关的所有信息内容（包括但不限于文字、图片、音频、视频、图表、界面设计、版面框架、有关数据或电子文档等）均受中华人民共和国法律法规和相应的国际条约保护，上海市小萝莉科技有限公司享有上述知识产权，但相关权利人依照法律规定应享有的权利除外。\n5.2 未经上海市小萝莉科技有限公司或相关权利人书面同意，你不得为任何商业或非商业目的自行或许可任何第三方实施、利用、转让上述知识产权。\n六、其他\n6.1 你使用本软件即视为你已阅读并同意受本协议的约束。上海市小萝莉科技有限公司有权在必要时修改本协议条款。你可以在本软件的最新版本中查阅相关协议条款。本协议条款变更后，如果你继续使用本软件，即视为你已接受修改后的协议。如果你不接受修改后的协议，应当停止使用本软件。\n6.2 本协议签订地为中华人民共和国上海市丰台区。\n6.3 本协议的成立、生效、履行、解释及纠纷解决，适用中华人民共和国法律（不包括冲突法）。\n6.4 若你和上海市小萝莉科技有限公司之间发生任何纠纷或争议，首先应友好协商解决；协商不成的，你同意将纠纷或争议提交本协议签订地有管辖权的人民法院管辖。\n6.5 本协议所有条款的标题仅为阅读方便，本身并无实际涵义，不能作为本协议涵义解释的依据。\n6.6 本协议条款无论因何种原因部分无效或不可执行，其余条款仍有效，对双方具有约束力。（正文完）\n上海市小萝莉科技有限公司";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated{
    WS(ws);
    
    [self.myTextview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view);
    }];
    self.myTextview.font = [UIFont fontWithName:@"Arial" size:16.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end