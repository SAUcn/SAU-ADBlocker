<script>
    import React from 'react';
    import {observer} from 'mobx-react';
    import {
        message, Row, Col, Table, Card, Input, Button
    } from 'antd';
    
    import Model from '../model/Model.js';
    
    export default @observer class extends React.Component {
        constructor(props) {
            super(props);
            this.state = {
                list : [],
                columns : [
                    {
                        title : 'Rule',
                        dataIndex : 'rule',
                        key : 'rule'
                    },
                    {
                        title : 'Operation',
                        dataIndex : 'operation',
                        key : 'operation'
                    }
                ]
            };
        }
        render() 
        {
            let list = this.state.list;
            list = list.map((item, index) => {
                return {
                    rule : <Input addonBefore='rule:' defaultValue={item.rule} onChange={(e) => this.change(e, index)}/>,
                    operation : <Button onClick={(e) => this.delete(e, index)}>删除</Button>,
                    key : index
                };
            });
            return (
                <div>
                    <Row style={{
                            paddingTop : '20px'
                        }}>
                        <Col span={16} offset={4}>
                            <Card title={
                                    <Row>
                                        <Col span={16}>Edit Rules</Col>
                                        <Col span={2} offset={2}>
                                            <Button type='primary' onClick={() => this.add()}>Add</Button>
                                        </Col>
                                        <Col span={2} offset={2}>
                                            <Button type='primary' onClick={() => this.save()}>Save</Button>
                                        </Col>
                                    </Row>
                                }>
                                <Table dataSource={list} columns={this.state.columns}/>
                            </Card>
                        </Col>
                    </Row>
                </div>
            );
        }
        save(list) {
            if (!list)
            {
                message.success('Saved!!!');
                list = this.state.list;
            }
            chrome.storage.local.set({
                'list' : list.filter(i => i.rule.trim() != '')
            });
        }
        add() {
            message.success('Added! Please Save!');
            let list = this.state.list;
            list.push({
                rule : ''
            });
            this.setState({list : list});
        }
        change(e, i) {
            let list = this.state.list;
            list[i].rule = e.target.value;
            this.setState({list : list});
        }
        delete(e, i) {
            message.warning('Deleteed! Please Save!');
            let list = this.state.list;
            list = list.filter((item, index) => index != i);
            this.setState({list : list});
        }
        componentDidMount() {
            chrome.storage.local.get('list', res => {
                if (!res.hasOwnProperty('list'))
                {
                    res.list = [
                        {
                            rule : 'http://g.gclick.cn/*',
                        },
                        {
                            rule : 'http://*.minisplat.cn/*'
                        }
                    ];
                    this.save(res.list);
                }
                this.setState({
                    list : res.list
                });
            });
        }
    }
</script>

<style lang='less' scoped>
</style>
     
